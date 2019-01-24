# frozen_string_literal: true

shared_examples_for 'sysctl resource' do
  it { is_expected.to have_sysctl_resource_count(1) }

  it do
    is_expected.to contain_sysctl('vm.foo').only_with('name' => 'vm.foo',
                                                      'ensure'    => 'present',
                                                      'value'     => '0',
                                                      'provider'  => 'augeas')
  end
end

shared_context 'sysctl' do
  it { is_expected.to have_sysctl_resource_count(0) }

  let :example_params do
    { 'vm.foo' => { 'value' => '0' } }
  end

  context 'when sysctl_hash is a Hash' do
    let(:params) { { sysctl_hash: example_params } }
    let(:facts) { {} }

    include_examples 'sysctl resource'
  end

  context 'when ::augeasproviders_sysctl_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_sysctl_hash: example_params } }

    include_examples 'sysctl resource'
  end
end
