module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text , img)
import Html.Events exposing (onClick)
import String
import Json.Decode exposing (Decoder, field, string)
import Http
import Html.Attributes exposing (src)


type alias Model = 
    {url : String}


    
    
type Msg
    = Next
    | GotPic (Result Http.Error String)
  

update : Msg -> Model -> (Model,Cmd Msg)
update msg model =
    case msg of
        Next ->
            (model, getRandomCatPic)
        GotPic result ->
            case result of
                Ok url ->
                    ({model | url = "ha"}, Cmd.none)
                    -- (Showing url, Cmd.none)

                Err _ ->
                    ({model | url = ""}, Cmd.none)


view : Model -> Html Msg
view model =
   
    div []
        [ img [src model.url] []
        , button [ onClick Next] [text "Next Cat"]
        ]

getRandomCatPic : Cmd Msg
getRandomCatPic =
  Http.get
    { url = "https://random-d.uk/api/v2/random"
    , expect = Http.expectJson GotPic picDecoder
    }


picDecoder : Decoder String
picDecoder =
  field "url" string

init : () -> (Model, Cmd Msg)
init _ =
  ({url = "https://picsum.photos/200/300"}, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
