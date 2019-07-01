# What's this
It's a curriculum design of the course Principals of Compiler. It includes lexing and parsing part of a SQL compiler. It reads a simple SQL sentense and prints a syntax tree to a HTML file.
# How to compile
Under Linux just enter its folder and type `make`.
# How to use
Edit `sample.txt`, replace its content with your own SQL sentense, and then:
```
sql_parser < sample.txt > output.html // Under Linux
sql_parser.exe < sample.txt > output.html // Under Windows
```
OK, now you can open `output.html` with a browser and a syntax tree is shown.