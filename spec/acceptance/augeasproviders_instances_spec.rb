# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'augeasproviders::instances class' do
  context 'when sysctl_hash is defined' do
    it 'runs successfully' do
      pp = <<-EOS
        class { 'augeasproviders::instances':
          sysctl_hash => { 'net.ipv4.ip_forward' => { 'value' => '1' } },
        }
      EOS

      apply_manifest(pp, catch_failures: true)
      expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
    end

    describe linux_kernel_parameter('net.ipv4.ip_forward') do
      its(:value) { is_expected.to eq 1 }
    end
  end

  context 'when augeasproviders_sysctl_hash is defined' do
    it 'runs successfully' do
      pp = <<-EOS
        $augeasproviders_sysctl_hash = { 'net.ipv4.ip_forward' => { 'value' => '0' } }
        class { 'augeasproviders::instances': }
      EOS

      apply_manifest(pp, catch_failures: true)
      expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
    end

    describe linux_kernel_parameter('net.ipv4.ip_forward') do
      its(:value) { is_expected.to eq 0 }
    end
  end
end
