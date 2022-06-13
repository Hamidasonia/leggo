import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class QueryDatabase {
  static String loginUser = """
  query loginUser(\$email: String, \$password: String){
  users(where: {email: {_eq: \$email}, password: {_eq: \$password}}){
    id
    fullname
    email
    username
    password
    tgl_daftar
  }
}
  """;

  static HttpLink httpLink = HttpLink(
      "https://discrete-grouse-84.hasura.app/v1/graphql",
      defaultHeaders: {
        "content_type": "application/json",
        "x-hasura-admin-secret":
            "c63wgyw7Q7fb1KsLqVx6HVHXCI8375QxHG2UiO3pblCk35Bqm5x0zKB0awGxDCwy",
      });

  static Link link = httpLink;
  static ValueNotifier<GraphQLClient> client =
      ValueNotifier(GraphQLClient(link: link, cache: GraphQLCache()));
}
