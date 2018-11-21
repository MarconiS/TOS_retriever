get_field_measures <- function(){
  folder_f = list.files("./TOS_retriever/inputs/dataField/NEON_struct-woody-plant")
  #ff = folder_f[1]
  tree_data <- NULL
  for(ff in folder_f){
    tree_name = list.files(paste("./TOS_retriever/inputs/dataField/NEON_struct-woody-plant",ff,sep="/"), pattern = "apparent")
    if(length(tree_name)!=0){
      file_tree_data = read_csv(paste("./TOS_retriever/inputs/dataField/NEON_struct-woody-plant",ff, tree_name, sep="/"))%>%
        select(c("individualID","tagStatus","growthForm","plantStatus","stemDiameter",
                 "height","baseCrownHeight","breakHeight","breakDiameter","maxCrownDiameter",
                 "ninetyCrownDiameter","canopyPosition","shape", "basalStemDiameter",
                 "basalStemDiameterMsrmntHeight", "maxBaseCrownDiameter", "ninetyBaseCrownDiameter"))

      tree_data <- rbind(tree_data, file_tree_data)
    }
  }
  write_csv(tree_data, './TOS_retriever/out/tree_measurements.csv')
}
