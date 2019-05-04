module A exposing (Model, Msg(..), changeOrg, init, update, view)

import Html
import Html.Events as HE
import Org


type alias Model =
    { value : Int, modifier : Int }


type Msg
    = Add
    | Sub


init =
    ( Model 0 1, Cmd.none )


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.text (String.fromInt model.value)
        , Html.text ("modifier " ++ String.fromInt model.modifier)
        , Html.button [ HE.onClick Add ] [ Html.text "Add" ]
        , Html.button [ HE.onClick Sub ] [ Html.text "Sub" ]
        ]


changeOrg : Org.Change -> Model -> ( Model, Cmd Msg )
changeOrg oMsg model =
    case oMsg of
        Org.Changed org ->
            let
                modifier =
                    case org.value of
                        "crows" ->
                            2

                        _ ->
                            1
            in
            ( { model | modifier = modifier }, Cmd.none )

        _ ->
            ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Add ->
            ( { model | value = model.value + model.modifier }, Cmd.none )

        Sub ->
            ( { model | value = model.value - model.modifier }, Cmd.none )
