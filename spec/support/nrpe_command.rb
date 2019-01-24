# frozen_string_literal: true

shared_examples_for 'nrpe_command resource' do
  it { is_expected.to have_nrpe_command_resource_count(1) }

  it do
    is_expected.to contain_nrpe_command('check_foo').only_with('name' => 'check_foo',
                                                               'ensure'    => 'present',
                                                               'command'   => '/usr/bin/check_foo',
                                                               'provider'  => 'augeas')
  end
end

shared_context 'nrpe_command' do
  it { is_expected.to have_nrpe_command_resource_count(0) }

  let :example_params do
    { 'check_foo' => { 'command' => '/usr/bin/check_foo' } }
  end

  context 'when nrpe_command_hash is a Hash' do
    let(:params) { { nrpe_command_hash: example_params } }
    let(:facts) { {} }

    include_examples 'nrpe_command resource'
  end

  context 'when ::augeasproviders_nrpe_command_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_nrpe_command_hash: example_params } }

    include_examples 'nrpe_command resource'
  end
end
