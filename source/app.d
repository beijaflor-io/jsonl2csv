import std.stdio;
import std.csv;
import std.json;

void main() {
  foreach (line; stdin.byLine) {
    auto j = parseJSON(line);
    j.writeln;
  }
}
