module Main where

import Text.Read (readPrec,readListPrec,Lexeme(..),lexP,parens,readMaybe,readListPrecDefault)

main :: IO ()
main = putStrLn "Hello, World!!"

data Date = Date Int Int Int deriving (Show)

instance Read Date where
{--  
  readsPrec p = (\r -> [(Date y m d,r) |
                        (y,r) <- readsPrec p r,
                        ("/",r) <- lex r,
                        (m,r) <- readsPrec p r,
                        ("/",r) <- lex r,
                        (d,r) <- readsPrec p r ])
--}

  readsPrec p r = do
    (y,r)   <- readsPrec p r
    ("/",r) <- lex r
    (m,r)   <- readsPrec p r
    ("/",r) <- lex r
    (d,r)   <- readsPrec p r
    return (Date y m d,r)


{--
  readPrec = parens $ do
    y <- readPrec
    Char '/' <- lexP
    m <- readPrec
    Char '/' <- lexP
    d <- readPrec
    return (Date y m d)

  readListPrec = readListPrecDefault
--}
  
-- readMaybe "2017/2/13" :: Maybe Date

                  

newtype Date' = Date' { getDate :: Date } deriving (Show)

instance Read Date' where
    readsPrec p = (\r -> [(Date' (Date y m d),r) |
                        (y,r) <- readsPrec p r,
                        ("-",r) <- lex r,
                        (m,r) <- readsPrec p r,
                        ("-",r) <- lex r,
                        (d,r) <- readsPrec p r ])
                  
-- getDate <$> (readMaybe "2017-2-13" :: Maybe Date')
