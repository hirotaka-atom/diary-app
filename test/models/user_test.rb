require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def set_up
    @user=User.new(name: "hirotaka", email: "hirotaka@softbank.ne.jp", password: "foobar", password_confirmation: "foobar", image_name: "th_app_icon_account.jpg")
  end

  test "should be valid" do
    set_up
    assert @user.valid?
  end

  test "name should be present" do
    set_up
    @user.name=""
    assert_not @user.valid?
  end

  test "email should be present" do
    set_up
    @user.email=""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    set_up
    @user.name="a"*51
    @user.valid?
  end

  test "email should not be too long" do
    set_up
    @user.email="a"*244+"@softbank.ne.jp"
    @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses=%w[user@softbank.ne.jp USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      set_up
      @user.email=valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses=%w[user@example,com user_at_foo.org user..name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      set_up
      @user.email=invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    set_up
    duplicate_user=@user.dup
    duplicate_user.email=@user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    set_up
    mixed_case_email="Foo@ExAMPle.CoM"
    @user.email=mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    set_up
    @user.password=" "*6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    set_up
    @user.password="a"*5
    assert_not @user.valid?
  end
end
