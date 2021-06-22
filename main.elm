module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import String
import Array exposing (Array)



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
        [ div [] [ text (Maybe.withDefault "ERROR" <|Array.get model.count model.catNames) ]
        , button [ onClick Next] [text "Next Cat"]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = 
            { catNames = Array.fromList ["Oliver", "Tobey", "Lucky", "Poyo", "Charlie"]
            , count = 0
            }
        , view = view
        , update = update
        }
