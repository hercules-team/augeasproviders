# frozen_string_literal: true

shared_examples_for 'host resource' do
  it { is_expected.to have_host_resource_count(1) }

  it do
    is_expected.to contain_host('foo').only_with('name' => 'foo',
                                                 'ensure'    => 'present',
                                                 'ip'        => '192.168.1.1',
                                                 'provider'  => 'augeas')
  end
end

shared_context 'host' do
  it { is_expected.to have_host_resource_count(0) }

  let :example_params do
    { 'foo' => { 'ip' => '192.168.1.1' } }
  end

  context 'when host_hash is a Hash' do
    let(:params) { { host_hash: example_params } }
    let(:facts) { {} }

    include_examples 'host resource'
  end

  context 'when ::augeasproviders_host_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_host_hash: example_params } }

    include_examples 'host resource'
  end
end
