# SERVER
shinyServer(function(input, output, session) {

  # Update select input for stock choices
  updateSelectizeInput(session, 
                    inputId = "stock", 
                    choices = stock_selection(),
                    server = TRUE,
                    options = list(highlight   = FALSE,
                                   labelField  = 'symbol', 
                                   searchField = "company", 
                                   valueField  = "symbol", 
                                   render = I(
                                              '{
                                                option: function(item, escape) {
                                                  return "<div><strong>" + escape(item.symbol) + "</strong> - " +
                                                  item.company + "</div>";
                                                }
                                              }')))
  
  # Reactive of the mtcars data to render. This could really be any reactive function (in a diff file)
  user_data <- download_data(input, output, session)
  
  # Add options
  final_data <- add_options(input, output, session, user_data)
  
  # Dygraph module
  callModule(renderDynamicDygraph,
             id     = "chart",
             .data  = final_data,
             op     = reactive({req(input$TTR_options)}),
             cols   = reactive({req(input$cols)}))
  
})
