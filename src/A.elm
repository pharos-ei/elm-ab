module A exposing (Model, Msg(..), init, update, view)

import Html
import Html.Events as HE


type alias Model =
    { value : Int }


type Msg
    = Add
    | Sub


init =
    ( Model 0, Cmd.none )


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.text (String.fromInt model.value)
        , Html.button [ HE.onClick Add ] [ Html.text "Add" ]
        , Html.button [ HE.onClick Sub ] [ Html.text "Sub" ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Add ->
            ( { model | value = model.value + 1 }, Cmd.none )

        Sub ->
            ( { model | value = model.value - 1 }, Cmd.none )
