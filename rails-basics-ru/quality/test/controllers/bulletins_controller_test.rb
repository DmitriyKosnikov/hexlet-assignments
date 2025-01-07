require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  self.use_transactional_tests = true

  def setup
    @bulletin = bulletins(:times)
  end

  test '#index' do
    get bulletins_path(:index)

    assert_response :success
    assert_select 'h1', 'Bulletins'
    assert_select 'ul li', @bulletin.title
  end

  test '#show' do
    get bulletins_url(@bulletin.id)

    assert_response :success
    assert_select 'h1', 'Bulletins'
  end
end
