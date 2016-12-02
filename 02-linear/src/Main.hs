module Main where
	
import Linear.Affine
import Linear.Matrix
import Linear.Metric
import Linear.Vector
import Linear.V2
import Linear.V3

main :: IO ()
main = do

 print "Get the difference between two points as a vector offset."
 print $ (V2 1 2) .-. (V2 3 4)

 print "Add a vector offset to a point."
 print $ (V2 1 2) .+^ (V2 10 20)

 print "Subtract a vector offset from a point."
 print $ (V2 1 2) .-^ (V2 10 20)

 print "Distance between two points in an affine space"
 print $ distanceA (V2 1 2) (V2 3 4)



 print "Matrix product."
 print $ V2 (V3 1 2 3) (V3 4 5 6) !*! V3 (V2 1 2) (V2 3 4) (V2 4 5)

 print "Entry-wise matrix addition."
 print $ V2 (V3 1 2 3) (V3 4 5 6) !+! V2 (V3 7 8 9) (V3 1 2 3)

 print "Matrix * column vector"
 print $ V2 (V3 1 2 3) (V3 4 5 6) !* V3 7 8 9

 print "Matrix-scalar product"
 print $ V2 (V2 1 2) (V2 3 4) !!* 5



 print "Compute the inner product of two vectors"
 print $ V2 1 2 `dot` V2 3 4



 print "Compute the sum of two vectors"
 print $ V2 1 2 ^+^ V2 3 4

