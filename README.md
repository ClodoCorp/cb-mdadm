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
