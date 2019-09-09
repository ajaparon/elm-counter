module Main exposing (Model)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    { counter : Int, max : Int, min : Int }


init : Model
init =
    Model 0 0 0


type Msg
    = ButtonClick Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        ButtonClick n ->
            let
                newCounter =
                    model.counter + n

                newMax =
                    if model.max < newCounter then
                        newCounter

                    else
                        model.max

                newMin =
                    if model.min > newCounter then
                        newCounter

                    else
                        model.min
            in
            { model | counter = newCounter, max = newMax, min = newMin }


view : Model -> Html Msg
view model =
    let
        steps =
            [ 1, 10, 100 ]

        viewButtonMinus step =
            viewButton -step

        dispMsg =
            "counter : "
                ++ String.fromInt model.counter
                ++ " max : "
                ++ String.fromInt model.max
                ++ " min : "
                ++ String.fromInt model.min

        viewArea =
            List.map viewButtonMinus steps
                ++ [ div [] [ text dispMsg ] ]
                ++ List.map viewButton steps
    in
    div [] viewArea


viewButton : Int -> Html Msg
viewButton n =
    let
        buttonFace =
            if n > 0 then
                "+" ++ String.fromInt n

            else
                String.fromInt n
    in
    button [ onClick (ButtonClick n) ] [ text buttonFace ]
