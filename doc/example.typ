#import "../../lib.typ": *
#show: doc
//============================================================================//

#pagebreak()
Header edge case.

//============================================================================//

= Mathematics

#exercise("x.x.x", [
  #lorem(20)

  $
        x_0 & = {(s,0)}             \
    x_(i+1) & = x_i union {(s,s-1)}
  $

  #lorem(13)
])

Definition. #lorem(30)

Lemma. #lorem(30)

Proof. #lorem(30)

Verified.

#theorem("x.x.x", [
  #lorem(20)

  $
    x_0 & = {(s,0)}             \
    x_i & = x_0 union {(s,s-1)}
  $

  #lorem(13)

  Test the following code: $"`if true then" "`t"_2 "`else" "`t"_3 --> "`t"_3$ where $"`t"_2 = "`t"_3$. #lorem(20)

  $
    #prooftree(rule(
      $"`if" "`t"_1 "`then" "`t"_2 "`else" "`t"_3 --> "`if" "`t"_1 "`then" "`t"'_2 "`else" "`t"_3$,
      $"`t"_2 --> "`t"'_2$,
    ))
  $

  Test the following expression $"`t"_1 in cal(T)_n$.

  // $"`v" ::= & wide & "values:"
  // \ & "`true" wide & "constant true"
  // \ & "`false" wide & "constant false"
  // \ & "`nv" wide & "numeric value"
  // \
  // \ "`nv" ::= & wide & "numeric values:"
  // \ & "`0" wide & "zero value"
  // \ & "`succ nv" wide & "successor value"$
  Consider the following grammar:
  #bnf(
    Prod($"`v"$, {
      Or[$"`true"$][_constant true_]
      Or[$"`false"$][_constant false_]
      Or[$"`nv"$][_numeric value_]
    }),
    Prod($"`nv"$, {
      Or[$"`0"$][_zero value_]
      Or[$"`succ nv"$][_successor value_]
    }),
  )
])

#lorem(20)
See :Exercise x.x.x. See :Theorem x.x.x.

#exercise("y.y.y", lorem(800))

//============================================================================//

= Using Entangled

== Hello World

#lorem(20)

``` {.c file=src/hello_world.c}
#include <stdlib.h>
#include <stdio.h>

<<example-main-function>>
```

#lorem(35)


``` {.c #hello-world}
puts("Hello world!");
```

#lorem(5)

``` {.c #example-main-function}
int main(int argc, char **argv) {
    <<hello-world>>
}
```

See :/example-main-function and :!src/hello_world.c for details.

#lorem(8)

``` {.cpp #hello-world}
return EXIT_SUCCESS;
```

#lorem(30)

``` {.bash .build target="target/hello_world" deps="src/hello_world.c"}
mkdir -p target
gcc src/hello_world.c -o target/hello_world
```
/*
``` {.bash .build target="target/hello_world_out0" deps="target/hello_world"}
./target/hello_world > target/hello_world_out0
```
*/
#code_exec(read("../target/hello_world_out0"))

#lorem(30)

//============================================================================//
