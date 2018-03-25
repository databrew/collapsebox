library(shiny)
library(shinydashboard)

ui <- dashboardPage(
    dashboardHeader(title = 'Collapsing boxes in shiny dashboard'),
    dashboardSidebar(),
    dashboardBody(
        uiOutput('main_ui')
    )
)

server <- function(input, output){
    
    # Create reactive values indicating whether a box should be collapsed or not
    collapser <- reactiveValues()
    collapser$a <- collapser$b <- collapser$c <- FALSE
    
    # Observe the checkboxes, and updated the value
    observeEvent(input$collapse_a, {
        # Upon click, change the value. Do false and then true,
        # so as to trigger a reset, even if the value is already true.
        collapser$a <- FALSE
        collapser$a <- TRUE
        message('Clicked collapser A.')
    })
    observeEvent(input$collapse_b, {
        collapser$b <- FALSE
        collapser$b <- TRUE
        message('Clicked collapser B.')
    })
    observeEvent(input$collapse_c, {
        collapser$b <- FALSE
        collapser$c <- TRUE
        message('Clicked collapser C.')
    })
    
    output$main_ui <-
        renderUI({
            
            # Observe the collapsers before rendering anything
            cc <- collapser
            
            fluidPage(
                fluidRow(
                    shinydashboard::box(title = 'Box A',
                                        footer = 'Some stuff',
                                        status = 'primary',
                                        width = 4,
                                        collapsible = TRUE,
                                        collapsed = collapser$a,
                                        actionButton('collapse_a',
                                                     label  = 'Collapse this box')),
                    shinydashboard::box(title = 'Box B',
                                        footer = 'Some stuff',
                                        status = 'primary',
                                        width = 4,
                                        collapsible = TRUE,
                                        collapsed = collapser$b,
                                        actionButton('collapse_b',
                                                     label  = 'Collapse this box')),
                    shinydashboard::box(title = 'Box C',
                                        footer = 'Some stuff',
                                        status = 'primary',
                                        width = 4,
                                        collapsible = TRUE,
                                        collapsed = collapser$c,
                                        actionButton('collapse_c',
                                                     label  = 'Collapse this box'))
                )
                
            )
        })
    
}

shinyApp(ui, server)