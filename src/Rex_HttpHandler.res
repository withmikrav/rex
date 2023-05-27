type contextT = {
  path: Rex_Path.t,
  method: Rex_Method.t,
  req: Rex_Request.t,
  res: Rex_Response.t,
  // query: Js.Json.t,
  // body: Body.t,
  // pubsub: PubSub.t('a),
}

let makeHandler = (app, handler: contextT => unit) => {
  app->Uws.any("/*", (res, req) => {
    let path = Rex_Path.make(req->Rex_Request.getUrl())
    let method = Rex_Method.make(req->Rex_Request.getMethod())

    // let pubsub = PubSub.makeForHttp(app)

    // let handlerFromBody = body => handler({req, res, body, query, pubsub, verb, path})

    handler({req, res, path, method})

    // switch verb {
    // | Get
    // | Head =>
    //   handlerFromBody(Empty)
    // | _ =>
    //   let contentType = List.hd(Request.getContentType(req))

    //   Body.getFromBuffer(
    //     body => {handlerFromBody(Body.make(body, contentType))},
    //     () => {Js.log("Not a body")},
    //     res,
    //   )
    // }
  })
}
