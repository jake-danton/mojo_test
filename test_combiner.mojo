from combiner import Combiner
from testing import assert_equal

def test_combiner():
    var c = Combiner(0)
    assert_equal(c.combine(1).combine(2).val, 3)