object controllerViacep: TcontrollerViacep
  Height = 480
  Width = 640
  object RESTClient1: TRESTClient
    BaseURL = 'https://viacep.com.br/ws'
    Params = <>
    SynchronizedEvents = False
    Left = 520
    Top = 144
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body15E36D6327BD44D0850A7C2BEE617314'
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
    Resource = '72235802/json'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 520
    Top = 200
  end
  object RESTResponse1: TRESTResponse
    Left = 520
    Top = 256
  end
end
