include Uws.Response

let contentType = (res, string) => {
  res->writeHeader("Content-Type", string)
}

let status = (res, code, message) => {
  res->writeStatus(code->string_of_int ++ " " ++ message)
}

let send = (res, data) => {
  res->end(data)->ignore
}

let text = (res, data) => {
  res->contentType("text/plain")->send(data)
}

let json = (res, data) => {
  switch Js.Json.stringifyAny(data) {
  | Some(data) => res->contentType("application/json")->send(data)
  | None => res->status(500, "Internal Server Error")->send("Parsing Json Error")
  }
}
