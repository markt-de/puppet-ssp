# frozen_string_literal: true

require 'spec_helper'

describe 'ssp' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with default parameters' do
        let(:params) do
          {
            version: '1.5.2',
          }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ssp::config') }
        it { is_expected.to contain_class('ssp::install') }
        it { is_expected.to contain_file('/opt/self-service-password-1.5.2/conf/config.inc.local.php') }
        it { is_expected.to contain_file('/opt/ssp') }
        it { is_expected.to contain_archive('/opt/self-service-password-1.5.2.tar.gz') }

        case os_facts[:osfamily]
        when 'Debian'
          it { is_expected.to contain_package('smarty3') }
        when 'RedHat'
          it { is_expected.to contain_package('php-Smarty') }
        when 'FreeBSD'
          it { is_expected.to contain_package('smarty-php81') }
        end
      end
    end
  end
end
