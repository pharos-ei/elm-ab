module B exposing (Model, Msg(..), init, update, view)

import Html
import Html.Events as HE


type alias Model =
    { value : String }


type Msg
    = Change String


init =
    ( Model "crow", Cmd.none )


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.button [ HE.onClick (Change "cows") ] [ Html.text "Cows" ]
        , Html.button [ HE.onClick (Change "crows") ] [ Html.text "Crows" ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change str ->
            ( { model | value = str }, Cmd.none )
