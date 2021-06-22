module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text , img)
import Html.Events exposing (onClick)
import String
import Array exposing (Array)
import Html.Attributes exposing (src)



type alias Model =
    { count : Int 
    , catNames : Array String
    }
    
type Msg
    = Next

update : Msg -> Model -> Model
update msg model =
    case msg of
        Next ->
            { model | count = 
                        if model.count + 1 >= Array.length model.catNames then
                            0
                        else
                            model.count + 1 
            }


view : Model -> Html Msg
view model =
    div []
        [ div [] [ img [src (Maybe.withDefault "ERROR" <|Array.get model.count model.catNames)] []]
        , button [ onClick Next] [text "Next Cat"]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = 
            { catNames = Array.fromList ["https://res.cloudinary.com/practicaldev/image/fetch/s--fgOKthwm--/c_imagga_scale,f_auto,fl_progressive,h_420,q_auto,w_1000/https://thepracticaldev.s3.amazonaws.com/i/k2hqrpxwaz68a2nfrvj9.jpeg", "https://images.apilist.fun/the_cat_api_api.png", "https://blog.xojo.com/wp-content/uploads/2015/10/Cat1.pngt1466486449161", "https://images.unsplash.com/photo-1482066490729-6f26115b60dc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80", "https://shkspr.mobi/blog/wp-content/uploads/2016/05/A-pet-cat-typing-on-a-computer-keyboard.jpg"]
            , count = 0
            }
        , view = view
        , update = update
        }
