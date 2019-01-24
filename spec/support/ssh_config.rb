# frozen_string_literal: true

shared_examples_for 'ssh_config resource' do
  it { is_expected.to have_ssh_config_resource_count(1) }

  it do
    is_expected.to contain_ssh_config('HashKnownHosts').only_with('name' => 'HashKnownHosts',
                                                                  'ensure'    => 'present',
                                                                  'value'     => 'yes',
                                                                  'provider'  => 'augeas')
  end
end

shared_context 'ssh_config' do
  it { is_expected.to have_ssh_config_resource_count(0) }

  let :example_params do
    { 'HashKnownHosts' => { 'value' => 'yes' } }
  end

  context 'when ssh_config_hash is a Hash' do
    let(:params) { { ssh_config_hash: example_params } }
    let(:facts) { {} }

    include_examples 'ssh_config resource'
  end

  context 'when ::augeasproviders_ssh_config_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_ssh_config_hash: example_params } }

    include_examples 'ssh_config resource'
  end
end
