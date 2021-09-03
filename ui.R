#Define Semantic Page
ui <- semanticPage(
  #Define title
  h1('Ship Analyzer app', class="ui top center aligned attached header", style = 'padding: 1.5rem;'),
  #Define body
  div(class = "ui attached tertiary segment", style = 'display: flex; flex-direction: row;',
      #Define input and information panel
      div(class = "ui segment", style = 'margin: 5px; width: 30%;', 
          #Introduction
          h4('Introduction'),
          p('Welcome to our ship analyzer app, here you can select a ship from a variaty of available types and check the longest distance traveled from all the signals recieved'),
          h4('Information'), 
          # Pass dropdown module
          inputsUI("basic"),
          # Create simple card information
          div(class = "ui raised segment",
              div(
                p(class="ui green ribbon label", "Distance traveled"),
                p(),
                # Show distance output in meters
                # Lazy approach by creating an HTML tag to avoid context R conflict in style
                HTML(paste0('<h3>',textOutput("distance"), '</h3>')),
                # Show ship id output 
                # Lazy approach by creating an HTML tag to avoid context R conflict in style
                HTML(paste0('<p>',textOutput("id_ship"), '</p>')),
                div(class="extra content",
                    # Show ship type output 
                    # Lazy approach by creating an HTML tag to avoid context R conflict in style
                    HTML(paste0('<h4>',textOutput("type_ship"), '</h4>')))
              )
          )),
      # Define special segment for map
      div(class="ui segment", style = 'width: 100%; margin: 5px;',
          div(
            # Map output with its own sppiner
            leafletOutput("mymap", height=500) %>% withSpinner()
          ))
  ))



