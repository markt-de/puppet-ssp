# frozen_string_literal: true

require 'spec_helper'

describe 'ssp' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with default parameters' do
        let(:params) do
          {
            version: '1.5.2'
          }
        end
        
        it { is_expected.to compile }
        it { is_expected.to contain_class('ssp::config') }
        it { is_expected.to contain_class('ssp::install') }
        it { is_expected.to contain_file('/opt/self-service-password-1.5.2/conf/config.inc.local.php') }
        it { is_expected.to contain_archive('/opt/self-service-password-1.5.2.tar.gz').with_creates('/opt/self-service-password-1.5.2') }
        it { is_expected.to contain_package('smarty3').only_with_ensure('installed') }
      end
    end
  end
end
