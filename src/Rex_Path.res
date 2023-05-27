type t = list<string>

let removePreceeding = str => {
  switch Js.String.get(str, 0) {
  | "/" => Js.String.sliceToEnd(~from=1, str)
  | _ => str
  }
}

let removeTrailing = str =>
  switch Js.String.get(str, Js.String.length(str) - 1) {
  | "/" => Js.String.slice(~from=0, ~to_=-1, str)
  | _ => str
  }

let show = str =>
  switch str {
  | list{} => "/"
  | pathList => "/" ++ Js.Array.joinWith("/", Array.of_list(pathList))
  }

let make = rawPath =>
  switch rawPath {
  | ""
  | "/" =>
    list{}
  | raw =>
    // remove preceeding "/" and trailing
    let normalizedPath = raw->removePreceeding->removeTrailing

    // remove preceeding again, convert to list
    Array.to_list(Js.String.split("/", normalizedPath))
  }
