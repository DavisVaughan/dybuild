# Server side logic for the custom value box
#
# Description:
# Does something reactively, and updates the output value box
#
# Params:
# .data     = An unresolved reactive expression returning a data frame with a wealth column
# .subtitle = The subtitle for the value box
#
# Returns:
# Nothing. Updates output.
#
customValueBox <- function(input, output, session, .data, .subtitle) {

  # Reactive calculated value
  react_num <- reactive({
    
    # Evaluate reactive
    .data <- .data()
    
    # Format for output
    max(.data$mpg) %>% 
      round() %>%
    # format(big.mark = ",") %>%
      as.character() %>%
      paste0(., " mpg") 
  })
  
  # Value box output
  output$cust_box <- renderValueBox({
    
    # The value box to be rendered
    valueBox(
      value = react_num(), 
      subtitle = .subtitle
    )
  })
  
}

# UI logic for the custom value box
#
# Description:
# Returns a value box with a custID namespace'd `cust_box` output ID
#
# Params:
# custID    = The ID to prefix with NS
# .width    = The width of the box. Passed on the valueBoxOutput
#
# Returns:
# A valueBoxOutput
#
customValueBoxUI <- function(custID, .width) {
  
  # Name space the ID
  ns <- NS(custID)
  
  # Output
  valueBoxOutput(ns("cust_box"), width = .width)
}
