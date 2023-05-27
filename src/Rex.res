module Path = Rex_Path
module Method = Rex_Method
module Request = Rex_Request
module Response = Rex_Response
module Handler = Rex_HttpHandler

type rexOptionsT = {
  port?: int,
  onListen?: unit => unit,
  sslConfig?: Uws.appOptionsT,
  handler?: Handler.contextT => unit,
  isSSL?: bool,
}

let make = opts => {
  let app = switch (opts.sslConfig, opts.isSSL) {
  | (Some(config), Some(true)) => Uws.makeSSLApp(config)
  | (Some(config), Some(false)) => Uws.makeApp(config)
  | _ => Uws.makeApp({})
  }

  let createHttpApp = app =>
    switch opts.handler {
    | Some(handler) => app->Handler.makeHandler(handler)
    | None => app
    }

  let port = opts.port->Belt.Option.getWithDefault(3000)

  app
  ->createHttpApp
  ->Uws.listen(
    port,
    opts.onListen->Belt.Option.getWithDefault(() => {
      Js.log(`listening on port ${port->Belt.Int.toString}`)
    }),
  )
  ->ignore
}
