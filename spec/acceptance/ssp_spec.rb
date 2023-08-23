require 'spec_helper_acceptance'

describe 'ssp class' do
  context 'default parameters' do
    it 'is expected to work idempotently with no errors' do
      pp = <<-EOS
      if $facts['os']['family'] == 'Debian' {
        $group_name = 'nogroup'
      }
      else {
        $group_name = 'nobody'
      }

      class { 'ssp':
        group          => $group_name,
        manage_smarty  => false,
        user           => 'nobody',
        version        => '1.5.2',
      }
      EOS

      # Run it twice and test for idempotency
      idempotent_apply(pp, debug: false)
    end
  end
end
