module AB exposing (Model, Msg(..), main)

import A
import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE
import Org


main : Program () Model Msg
main =
    let
        ( a, cmdA ) =
            A.init

        ( b, cmdB ) =
            Org.init
    in
    Browser.element
        { init = \_ -> ( Model a b, Cmd.batch [ Cmd.map UpdateA cmdA, Cmd.map UpdateOrg cmdB ] )
        , view = view
        , update = update
        , subscriptions =
            \model ->
                Sub.batch
                    [ Sub.map UpdateA (A.subscriptions model.a)
                    , Sub.map UpdateOrg (Org.subscriptions model.b)
                    ]
        }


type alias Model =
    { a : A.Model
    , b : Org.Model
    }


type Msg
    = UpdateA A.Msg
    | UpdateOrg Org.Msg


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.text ("We have " ++ String.fromInt model.a.value ++ " " ++ model.b.value)
        , Html.map UpdateOrg (Org.view model.b)
        , Html.map UpdateA (A.view model.a)
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

        UpdateOrg bMsg ->
            let
                ( ( b, cmdB ), change ) =
                    Org.update bMsg model.b

                ( a, cmdA ) =
                    A.changeOrg change model.a
            in
            ( { model | b = b, a = a }
            , Cmd.batch
                [ Cmd.map UpdateOrg cmdB
                , Cmd.map UpdateA cmdA
                ]
            )
