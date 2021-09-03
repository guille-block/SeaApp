

# UI module for fecthing the dropdown inputs
#It will be sync through 'basic' with the 3 moduleServer components created below

inputsUI <-function(id){
  ns<-NS(id)
  tagList(
    div(style = 'display: flex; flex-direction: row;',
        div(style = 'width: 50%; padding: 1rem;',
            p('Ship Type'),
            dropdown_input(ns("id_select_1"), unique(ships$ship_type), value = unique(ships$ship_type)[1], type = 'selection fluid')
        ),
        div(style = 'width: 50%; padding: 1rem;',
            p('Vessel'),
            dropdown_input(ns("id_select_2"), unique(types$SHIP_ID), value = unique(types$SHIP_ID)[1], type = 'selection fluid')))
  )
}

# Lazy solution for accessing our inputs: "id_select_1" in our server
# ModuleServer connected through 'basic' with inputsUI
inputs1  <- function(id) {
  moduleServer(
    id,
    function(input,output,session){
      id_select_1 <-reactive({input$id_select_1})
      
      
      return(id_select_1)
    }
  )
}


# Lazy solution for accessing our inputs: "id_select_2" in our server
# ModuleServer connected through 'basic' with inputsUI
inputs2  <- function(id) {
  moduleServer(
    id,
    function(input,output,session){
      id_select_2 <-reactive({input$id_select_2})
      
      
      return(id_select_2)
    }
  )
}


# Update inputsUI dropdown inputs when there is a change in the type of ship ('id_select_1')
# moduleServer connected through 'basic' with inputsUI
updateInput <- function(id) {
  moduleServer(
    id,
    function(input,output,session){
  observeEvent(
    input$id_select_1,{
      
      id_by_type <- ships %>%
        filter(ship_type == input$id_select_1)
      
      update_dropdown_input(session, "id_select_2",
                            choices = unique(id_by_type$SHIP_ID),
                            value = unique(id_by_type$SHIP_ID)[1]
      )})
    })
}



