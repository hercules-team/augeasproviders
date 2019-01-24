# frozen_string_literal: true

shared_examples_for 'sshd_config resource' do
  it { is_expected.to have_sshd_config_resource_count(1) }

  it do
    is_expected.to contain_sshd_config('PermitRootLogin').only_with('name' => 'PermitRootLogin',
                                                                    'ensure'    => 'present',
                                                                    'value'     => 'yes',
                                                                    'provider'  => 'augeas')
  end
end

shared_context 'sshd_config' do
  it { is_expected.to have_sshd_config_resource_count(0) }

  let :example_params do
    { 'PermitRootLogin' => { 'value' => 'yes' } }
  end

  context 'when sshd_config_hash is a Hash' do
    let(:params) { { sshd_config_hash: example_params } }
    let(:facts) { {} }

    include_examples 'sshd_config resource'
  end

  context 'when ::augeasproviders_sshd_config_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_sshd_config_hash: example_params } }

    include_examples 'sshd_config resource'
  end
end
