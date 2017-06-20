##### Example function to return a reactive #######################################################

# A function to return mtcars
#
# Description:
# A function that returns mtcars as a reactive
#
# Params:
#
# Returns:
# mtcars
#
download_data <- function(input, output, session) {
  reactive({
    req(input$stock)
    
    if(length(input$stock) > 1) {
      tq_get(input$stock) %>% group_by(symbol)
    } else {
      tq_get(input$stock)
    }
      
  })
}

##### Add options #######################################################

# A function to return mtcars
#
# Description:
# A function that returns mtcars as a reactive
#
# Params:
#
# Returns:
# mtcars
#
add_options <- function(input, output, session, .data) {
  
  reactive({
    req(input$TTR_options)
    
     user_data <- .data()
    
     user_data <- map(.x = input$TTR_options, 
                      .f = ~tq_mutate_(data = user_data, select = "adjusted", mutate_fun = .)) %>%
                  Reduce(left_join, .)
     
     if(!is.null(user_data$symbol)) {
       user_data <- arrange(user_data, symbol)
     }
     
     output$txtBox <- renderDataTable({user_data})
     
     updateSelectInput(session = session, inputId = "cols", choices = colnames(user_data), selected = c("date", "adjusted"))
     
     user_data
 })
  
}


# A function to return a specific stock list
#
# Description:
# A function that returns mtcars as a reactive
#
# Params:
#
# Returns:
# mtcars
#
stock_selection <- function() {
  op <- tq_index_options()
  map_df(op, .f = ~suppressMessages(
                    tq_index(., use_fallback = TRUE))) %>%
    filter(!duplicated(symbol))
}
