type t =
  | Get
  | Post
  | Put
  | Patch
  | Delete
  | Options
  | Head
  | Trace
  | Connect

let make = method =>
  switch method {
  | "get" => Get
  | "post" => Post
  | "put" => Put
  | "patch" => Patch
  | "delete" => Delete
  | "options" => Options
  | "head" => Head
  | "connect" => Connect
  | "trace" => Trace
  | _ => Get
  }
