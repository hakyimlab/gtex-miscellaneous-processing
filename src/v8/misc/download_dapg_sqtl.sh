#!/bin/bash

[ -d data/dapg/sqtl ] || mkdir -p data/dapg/sqtl
cd data/dapg/sqtl
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Adipose_Subcutaneous.tar.gz -o Adipose_Subcutaneous.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Adipose_Visceral_Omentum.tar.gz -o Adipose_Visceral_Omentum.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Adrenal_Gland.tar.gz -o Adrenal_Gland.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Artery_Aorta.tar.gz -o Artery_Aorta.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Artery_Coronary.tar.gz -o Artery_Coronary.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Artery_Tibial.tar.gz -o Artery_Tibial.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Amygdala.tar.gz -o Brain_Amygdala.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Anterior_cingulate_cortex_BA24.tar.gz -o Brain_Anterior_cingulate_cortex_BA24.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Caudate_basal_ganglia.tar.gz -o Brain_Caudate_basal_ganglia.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Cerebellar_Hemisphere.tar.gz -o Brain_Cerebellar_Hemisphere.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Cerebellum.tar.gz -o Brain_Cerebellum.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Cortex.tar.gz -o Brain_Cortex.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Frontal_Cortex_BA9.tar.gz -o Brain_Frontal_Cortex_BA9.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Hippocampus.tar.gz -o Brain_Hippocampus.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Hypothalamus.tar.gz -o Brain_Hypothalamus.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Nucleus_accumbens_basal_ganglia.tar.gz -o Brain_Nucleus_accumbens_basal_ganglia.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Putamen_basal_ganglia.tar.gz -o Brain_Putamen_basal_ganglia.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Spinal_cord_cervical_c-1.tar.gz -o Brain_Spinal_cord_cervical_c-1.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Brain_Substantia_nigra.tar.gz -o Brain_Substantia_nigra.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Breast_Mammary_Tissue.tar.gz -o Breast_Mammary_Tissue.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Cells_Cultured_fibroblasts.tar.gz -o Cells_Cultured_fibroblasts.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Cells_EBV-transformed_lymphocytes.tar.gz -o Cells_EBV-transformed_lymphocytes.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Colon_Sigmoid.tar.gz -o Colon_Sigmoid.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Colon_Transverse.tar.gz -o Colon_Transverse.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Esophagus_Gastroesophageal_Junction.tar.gz -o Esophagus_Gastroesophageal_Junction.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Esophagus_Mucosa.tar.gz -o Esophagus_Mucosa.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Esophagus_Muscularis.tar.gz -o Esophagus_Muscularis.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Heart_Atrial_Appendage.tar.gz -o Heart_Atrial_Appendage.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Heart_Left_Ventricle.tar.gz -o Heart_Left_Ventricle.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Kidney_Cortex.tar.gz -o Kidney_Cortex.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Liver.tar.gz -o Liver.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Lung.tar.gz -o Lung.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Minor_Salivary_Gland.tar.gz -o Minor_Salivary_Gland.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Muscle_Skeletal.tar.gz -o Muscle_Skeletal.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Nerve_Tibial.tar.gz -o Nerve_Tibial.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Ovary.tar.gz -o Ovary.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Pancreas.tar.gz -o Pancreas.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Pituitary.tar.gz -o Pituitary.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Prostate.tar.gz -o Prostate.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Skin_Not_Sun_Exposed_Suprapubic.tar.gz -o Skin_Not_Sun_Exposed_Suprapubic.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Skin_Sun_Exposed_Lower_leg.tar.gz -o Skin_Sun_Exposed_Lower_leg.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Small_Intestine_Terminal_Ileum.tar.gz -o Small_Intestine_Terminal_Ileum.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Spleen.tar.gz -o Spleen.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Stomach.tar.gz -o Stomach.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Testis.tar.gz -o Testis.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Thyroid.tar.gz -o Thyroid.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Uterus.tar.gz -o Uterus.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Vagina.tar.gz -o Vagina.tar.gz
curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/Whole_Blood.tar.gz -o Whole_Blood.tar.gz

cd ../../..
