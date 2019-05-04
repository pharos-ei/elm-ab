module Org exposing (Change(..), Model, Msg(..), init, update, view)

import Html
import Html.Events as HE


type alias Model =
    { value : String }


type Msg
    = Change String


type Change
    = None
    | Loaded Model
    | Changed Model


init =
    ( Model "crows", Cmd.none )


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.button [ HE.onClick (Change "cows") ] [ Html.text "Cows" ]
        , Html.button [ HE.onClick (Change "crows") ] [ Html.text "Crows" ]
        , Html.button [ HE.onClick (Change "fish") ] [ Html.text "Fish" ]
        ]


update : Msg -> Model -> ( ( Model, Cmd Msg ), Change )
update msg model =
    case msg of
        Change str ->
            let
                newModel =
                    { model | value = str }
            in
            ( ( newModel, Cmd.none ), Changed newModel )
