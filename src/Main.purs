module Main where

import Prelude

import Data.Tuple.Nested ((/\))
import Deku.Control (text_)
import Deku.Core (Nut)
import Deku.DOM as D
import Deku.DOM.Attributes as DA
import Deku.DOM.Listeners as DL
import Deku.Do as Deku
import Deku.Hooks (useState)
import Deku.Toplevel (runInBody)
import Effect (Effect)
import FRP.Poll (Poll)

incrementer :: (Int -> Effect Unit) -> (Poll Int) -> Nut
incrementer setNumber number = Deku.do
  D.div [ DA.klass_ "flex items-center space-x-4 mb-4" ]
    [ button setNumber number "increment" (_ + 1)
    , button setNumber number "decrement" (_ - 1)
    , button setNumber number "reset" (const 0)
    , counter number
    ]

main :: Effect Unit
main = void $ runInBody Deku.do
  setX /\ x <- useState 0
  setY /\ y <- useState 0
  D.div
    [ DA.klass_ "flex items-center justify-center min-h-screen bg-gray-100" ]
    [ D.div [ DA.klass_ "bg-white p-6 rounded-lg shadow-lg" ]
        [ incrementer setX x
        , incrementer setY y
        , D.div
            [ DA.klass_ "text-center mt-4" ]
            [ D.text $ show <$> ((+) <$> x <*> y) ]
        ]
    ]

button
  :: (Int -> Effect Unit)
  -> Poll Int
  -> String
  -> (Int -> Int)
  -> Nut
button setNumber number s f =
  D.div_
    [ D.button
        [ DA.klass_
            "w-28 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        , DL.runOn DL.click $ (setNumber <<< f) <$> number
        ]
        [ text_ s ]
    ]

counter :: Poll Int -> Nut
counter i = D.div_ [ D.text $ show <$> i ]

