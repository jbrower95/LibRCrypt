LibRCrypt by Justin Brower
=========

An Objective-C library for data encryption based on 3 dimensional rotations of data and commutative data transforms

The idea's pretty simple: If you represent data as the squares on a rubix cube, you can apply transformations to the data
and get back completely encrypted data -- all of which is commutatitive. Just as a rubix cube can be solved if you know 
all of the moves, this data can be "unwound", so to speak, if you know all of the transforms applied. Except, the encryption
is even deeper than that.

The whole concept of a cube can only cover (9 squares per face x 6 faces) 54 significant bits of data. Therefore, compressed
data must be composed of MULTIPLE -- even thousands -- of rubix cubes. Though passwords may be a bit longer, I can forsee
this being extremely secure, as the data will be forever skewed.

Why Objective-C? Well, I like it. It's not as "pretty" as C, but it's object oriented and i've grown to like the syntax.



Future Plans? As of this moment, a data format has not yet been defined. The encryption algorithims are working (and are fully comutative)
but the transferrable data cannot be produced as of now. This will of course be developed in the future.

The important part, however, is the proof of concept: data CAN be thought of as the vertices of a cube and transformed as such.

Credits: thanks to Andrew Brennan!
