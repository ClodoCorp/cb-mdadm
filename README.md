mdadm
===========


devices => {
  'dm_name' => {
    'devices' => [ {'/dev/sd.*' => 'accept'}, {'.*' => 'reject'} ],
    'options' => {
      'xxx' => 'ttt'
    }
  }
}

### mdadm.conf
    "mdadm" => {
      "conf" => {
        "DEVICE" => "/dev/nothing",
        "CREATE" => {
          "owner" => "root",
          "group" => "disk",
          "mode" => "0660",
          "auto" => "yes"
        },
        "HOMEHOST" => "<system>",
        "MAILADDR" => "root",
        "ARRAY" => [
          {
              "name" => "test1"
          },
          "name=test2"
        ]
      }
    }
