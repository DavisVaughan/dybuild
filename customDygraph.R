# Server side logic for the example highchart
#
# Description:
# Renders the highchart
#
# Params:
# .data      = An unresolved reactive expression returning a user data frame
#
# Returns:
# Nothing. Updates output.
#
renderDynamicDygraph <- function(input, output, session, .data, op, cols) {
  
  # Create the highchart output
  output$dy <- renderDygraph({
    
    chart_data <- .data()
    
    
    if(!is.null(chart_data$symbol)) {
      
      chart_data <- chart_data %>%
        .[c("symbol", cols())] %>%
        gather(key = colname, value = colval, -symbol, -date) %>%
        unite(symname, symbol, colname) %>%
        filter(!duplicated(.)) %>%
        spread(key = symname, value = colval) %>%
        as_xts(date_col = date)
      
    } else {
      chart_data <- chart_data %>%
        .[cols()] %>%
        as_xts(date_col = date)
    }
    
    dygraph(chart_data) %>%
      dyOptions(connectSeparatedPoints=TRUE)
  })
  
}

# UI logic for the example dygraph
#
# Description:
# Returns a highchart output with a dyID namespace'd `dy` output ID
#
# Params:
# dyID    = The ID to prefix with NS
# .height = The height of the chart. Passed on the dygraphOutput
#
# Returns:
# A highchartOutput
#
exampleDygraphOutputUI <- function(dyID, .height) {
  
  # Name space the ID
  ns <- NS(dyID)
  
  # Output
  dygraphOutput(ns("dy"), height = .height)
}
