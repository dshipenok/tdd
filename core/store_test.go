package core

import (
	. "gopkg.in/check.v1"
)

type StoreSuite struct {
}

var _ = Suite(&StoreSuite{})

func (s *StoreSuite) Test_(c *C) {
	c.Assert(nil, IsNil)
}