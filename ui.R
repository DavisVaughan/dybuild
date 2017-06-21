# UI
shinyUI(dashboardPage(
  
  # HEADER ----------------------------------------------------------
  dashboardHeader(title = "Chart Builder"),
  
  # SIDEBAR ---------------------------------------------------------
  dashboardSidebar(disable = TRUE),
  
  # BODY ------------------------------------------------------------
  dashboardBody(
    
    # Custom CSS colors
    #tags$head(
    #  tags$link(rel = "stylesheet", type = "text/css", href = "./custom.css")
    #),
    
    # Row 1 ---------------------------------------------------------
    fluidRow(
      
      # Column 1 ----------------------------------------------------
      box(
        title = "Technical Trading Rules",
        width = 9,
        
        # Chart output
        exampleDygraphOutputUI("chart", .height = 400)

      ),
      
      # Column 2 ----------------------------------------------------
      box(
        title = "Options",
        width = 3,
        
        selectizeInput("stock", 
                   label = "Stock Selection", 
                   choices = NULL, 
                   multiple = TRUE),
        
        selectInput("TTR_options", label = "TTR Options", 
                    choices = TTR_functions(), multiple = TRUE),
        
        selectInput("cols", label = "Column Selection", multiple = TRUE, choices = NULL)
      )
      
    ), # End row 1
    
    # Row 2 ---------------------------------------------------------
    fluidRow(
      
      # Summary box
      box(
        title = "Data table of selections",
        width = 12,
        
        dataTableOutput("txtBox")
      )
      
      
    ) # End row 2
  ) # End body
)) # End page / UI
