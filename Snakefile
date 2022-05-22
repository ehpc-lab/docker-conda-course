SAMPLES = ["A", "B"]

rule all:
	input: "results/plots/quals.svg"

rule bwa_map:
	input:
		"data/genome.fa",
		"data/samples/{sample}.fastq"
	output:
		"results/mapped_reads/{sample}.bam"
	benchmark:
		"benchmark/{sample}.bwa.benchmark.txt"
	threads: 6
	shell:
		"bwa mem {input} -t {threads} | samtools view -Sb - > {output}"

rule samtools_sort:
	input:
		"results/mapped_reads/{sample}.bam"
	output:
		"results/sorted_reads/{sample}.bam"
	shell:
		"samtools sort -T results/sorted_reads/{wildcards.sample} "
		"-O bam {input} > {output}"

rule samtools_index:
	input:
		"results/sorted_reads/{sample}.bam"
	output:
		"results/sorted_reads/{sample}.bam.bai"
	shell:
		"samtools index {input}"

rule bcftools_call:
	input:
		fa="data/genome.fa",
		bam=expand("results/sorted_reads/{sample}.bam",     sample=SAMPLES),
		bai=expand("results/sorted_reads/{sample}.bam.bai", sample=SAMPLES)
	output:
		"results/calls/all.vcf"
	shell:
		"bcftools mpileup -f {input.fa} {input.bam} | "
		"bcftools call -mv - > {output}"

rule plot_quals:
	input:
		"results/calls/all.vcf"
	output:
		"results/plots/quals.svg"
	script:
		"scripts/plot-quals.py"
