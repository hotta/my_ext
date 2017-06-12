<?php

use PHPUnit\Framework\TestCase;

class MyAddReturnIntTest extends TestCase
{
  public function test3plus4returns7()
  {
    $ret = my_add_return_int(3, 4);
    $this->assertEquals(7, $ret);
  }
}
