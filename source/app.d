import std.algorithm;
import std.array;
import std.regex;
import std.conv;
import std.csv;
import std.json;
import std.stdio;

auto getHeader(JSONValue j) {
  auto keys = j.object.keys;
  return keys
    .filter!((string key) => j[key].type != JSON_TYPE.OBJECT && j[key].type != JSON_TYPE.ARRAY)
    .map!(x => x);
}

string[] getRow(string[] header, JSONValue j) {
  static auto jsonEmptyString = JSONValue("");
  static auto forwardSlashes = ctRegex!("\\\\/");
  return header
    .map!((string key) => j.object.get(key, jsonEmptyString).to!string())
    .map!((string svalue) => replaceAll(svalue, forwardSlashes, "/"))
    .array;
}

void printRow(bool delimit = false)(string[] row) {
  static if (delimit) {
    row.map!(x => "\"" ~ x ~ "\"").join(",").writeln;
  } else {
    row.join(",").writeln;
  }
}

void main() {
  auto noHeader = true;
  string[] header;

  foreach (line; stdin.byLine) {
    auto j = parseJSON(line);
    if (!j.type == JSON_TYPE.OBJECT) {
      throw new Error("Found line that wasn't an object");
    }

    if (noHeader) {
      header = getHeader(j).array;
      noHeader = false;
      printRow!true(header);
    }

    printRow!false(getRow(header, j));
  }
}
