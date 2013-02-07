import              Data.Binary
import              Hdis86.Types
import qualified    Data.Map        as M
import qualified    Data.Set        as S
import              Igor
import              Igor.ByteModel
import              Igor.Gadget
import              Igor.Gadget.Discovery
import qualified    Data.ByteString.Char8 as BS

main :: IO ()
main = do
    library <- decodeFile "library" :: IO GadgetLibrary
    sequence_ $ map prettyPrint $ M.toList library

    where
        prettyPrint (gadget, instances) = do
            putStrLn $ "Gadget: " ++ show gadget
            sequence_ $ map prettyPrint' $ S.toList instances

        prettyPrint' (meta, clobbered) = do
            putStr $ unlines . map (("\t"++) . mdAssembly) $ meta
            putStrLn $ "\tClobbered: " ++ show clobbered
            putStrLn $ "\t" ++ replicate 40 '-' ++ "\n"
