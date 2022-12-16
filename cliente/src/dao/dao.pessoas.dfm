object daoPessoas: TdaoPessoas
  Height = 480
  Width = 640
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:9000/datasnap/rest/cadastro/Pessoas'
    ContentType = 'application/json'
    Params = <>
    SynchronizedEvents = False
    Left = 200
    Top = 176
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Method = rmPUT
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body'
        Value = 
          ' {'#13#10'        "idPessoa": 4,'#13#10'        "flNatureza": "FISICA",'#13#10'   ' +
          '     "dsDocumento": "novo documento",'#13#10'        "nmPrimeiro": "Ra' +
          'fael",'#13#10'        "nmSegundo": "Silva",'#13#10'        "dtRegistro": "20' +
          '22-09-12T00:00:00.000Z",'#13#10'        "endereco": {'#13#10'            "id' +
          'Endereco": 4,'#13#10'            "dsCep": "123456",'#13#10'            "dsUF' +
          '": "",'#13#10'            "nmCidade": "",'#13#10'            "nmBairro": "",' +
          #13#10'            "nmLogradouro": "",'#13#10'            "dsComplemento": ' +
          '""'#13#10'        }'#13#10'    }'
        ContentTypeStr = 'application/json'
      end>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 200
    Top = 232
  end
  object RESTResponse1: TRESTResponse
    Left = 200
    Top = 288
  end
  object RESTClient2: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:9000/datasnap/rest/tcadastro/PessoasLote'
    ContentType = 'application/json'
    Params = <>
    SynchronizedEvents = False
    Left = 336
    Top = 176
  end
  object RESTRequest2: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient2
    Method = rmPUT
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body'
        Value = 
          ' {'#13#10'        "idPessoa": 4,'#13#10'        "flNatureza": "FISICA",'#13#10'   ' +
          '     "dsDocumento": "novo documento",'#13#10'        "nmPrimeiro": "Ra' +
          'fael",'#13#10'        "nmSegundo": "Silva",'#13#10'        "dtRegistro": "20' +
          '22-09-12T00:00:00.000Z",'#13#10'        "endereco": {'#13#10'            "id' +
          'Endereco": 4,'#13#10'            "dsCep": "123456",'#13#10'            "dsUF' +
          '": "",'#13#10'            "nmCidade": "",'#13#10'            "nmBairro": "",' +
          #13#10'            "nmLogradouro": "",'#13#10'            "dsComplemento": ' +
          '""'#13#10'        }'#13#10'    }'
        ContentTypeStr = 'application/json'
      end>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 336
    Top = 240
  end
end
