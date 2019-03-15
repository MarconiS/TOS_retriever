get_joint_dataset <- function(){
  library(dplyr)
  chemical <- read_csv("./TOS_retriever/out/chemical_data.csv") %>%
    select(-one_of("toxicodendronPossible.x", "toxicodendronPossible.y", 
                   "chlorophyllSampleCode.x", "chlorophyllSampleCode.y",
                   "ligninSampleBarcode.x", "ligninSampleBarcode.y", 
                   "cnSampleCode.x", "cnSampleCode.y"))
  isotope <- read_csv("./TOS_retriever/out/isotopes_data.csv")
  structure <- read_csv("./TOS_retriever/out/field_data.csv") %>%
    select(-one_of("domainID", "siteID", "plotType", "coordinateUncertainty",
                   "elevation", "subplotID", "taxonID", "nlcdClass", "scientificName"))
  
  #join the products all available traits data first
  dat = inner_join(chemical, isotope,  by = "sampleID") %>%
    unique %>%
    write_csv('./TOS_retriever/out/field_traits_dataset.csv')
  
  # just the geolocalized data
  dat <-  inner_join(dat, structure, by = "individualID") %>% #) %>%
    unique %>% write_csv('./TOS_retriever/out/utm_dataset.csv')
}
