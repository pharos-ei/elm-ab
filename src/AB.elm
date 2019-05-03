module AB exposing (Model, Msg(..), main)

import A
import B
import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE


main : Program () Model Msg
main =
    let
        ( a, cmdA ) =
            A.init

        ( b, cmdB ) =
            B.init
    in
    Browser.element
        { init = \_ -> ( Model a b, Cmd.batch [ Cmd.map UpdateA cmdA, Cmd.map UpdateB cmdB ] )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { a : A.Model
    , b : B.Model
    }


type Msg
    = UpdateA A.Msg
    | UpdateB B.Msg


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.text ("We have " ++ String.fromInt model.a.value ++ " " ++ model.b.value)
        , Html.map UpdateA (A.view model.a)
        , Html.map UpdateB (B.view model.b)
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateA aMsg ->
            let
                ( a, cmdA ) =
                    A.update aMsg model.a
            in
            ( { model | a = a }, Cmd.map UpdateA cmdA )

        UpdateB bMsg ->
            let
                ( b, cmdB ) =
                    B.update bMsg model.b
            in
            ( { model | b = b }, Cmd.map UpdateB cmdB )
